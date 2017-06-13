require 'fileutils'
RSpec.describe FileManager do
  describe 'initialize wihtout arguments' do
    let(:f) { FileManager.new }
    it 'path should equal ./' do
      expect(f.path).to eq('./')
    end

    it 'excludes should equal empty string' do
      expect(f.excludes).to eq('')
    end
  end

  describe 'initialize with arguments' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }

    after(:all) do
      FileUtils.rm_rf(Dir['test/*'])
    end

    it 'path should equal tmp/test' do
      expect(f.path).to eq('test/test')
    end

    it 'should create directories' do
      exists = File.directory?(f.path)
      expect(exists).to be(true)
    end

    it 'excludes should eqaul test.rb' do
      expect(f.excludes).to eq('test.rb')
    end

    it 'excludes accepts array' do
      f.excludes = %w(test3.rb test4.rb)
      expect(f.excludes.class).to eq(Array)
    end
  end

  describe 'make_file' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'creates file in correct path and returns filename' do
      f.make_file('make_file.rb')
      expect(f.file_exists?('make_file.rb')).to eq(true)
    end

    it 'does not create file that exists' do
      mf = f.make_file('make_file.rb') && !f.file_exists?('make_file.rb')
      expect(mf).to eq(false)
    end
  end

  describe 'all_files' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }

    it 'should list all files in path not in excludes' do
      f.make_file('test.rb') unless f.file_exists?('test.rb')
      expect(f.all_files).not_to include('test.rb')
    end

    it 'should return an array' do
      expect(f.all_files.class).to be(Array)
    end
  end

  describe 'pwd' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'returns string with initialized path' do
      f.make_file('test1.rb') unless f.file_exists?('test1.rb')
      expect(f.pwd('test1.rb')).to eq('test/test/test1.rb')
    end
  end

  describe 'stats' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'returns error if file doesn\'t exist' do
      expect{
        f.stats('fake_file.rb', 'birthtime')
      }.to raise_error(FileManagementErrors, 'File doesn\'t exist')
    end

    it 'should return File::Stat object' do
      stat = f.stats('test1.rb', 'class')
      expect(stat).to eq(File::Stat)
    end
  end

  describe 'file_size' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }

    it 'should return false is file does not exist' do
      expect(f.file_size('not_real.rb')).to eq(false)
    end

    it 'should return string if file does exist' do
      f.make_file('exist.rb')
      expect(f.file_size('exist.rb').class).to eq(String)
    end
  end

  describe 'file_exists?' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'returns true if file exists' do
      expect(f.file_exists?('exist.rb')).to eq(true)
    end

    it 'returns false if file doesn\'t exist' do
      expect(f.file_exists?('not_real.rb')).to eq(false)
    end
  end

  describe 'rename' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'returns false if file doesn\'t exist' do
      rename = f.rename('not_real.rb', 'still_not_real.rb')
      expect(rename).to eq(false)
    end

    it 'returns false if new_name exists' do
      rename = f.rename('not_real.rb', 'make_file.rb' )
      expect(rename).to eq(false)
    end

    it 'returns 0 if file is renamed' do
      rename = f.rename('make_file.rb', 'made_file.rb')
      expect(rename).not_to eq(false)
    end
  end

  describe 'delete_file' do
    let(:f) { FileManager.new(path: 'test/test', excludes: 'test.rb') }
    it 'returns false if file doesn\'t exist' do
      delete = f.delete_file('not_real.rb')
      expect(delete).to eq(false)
    end
    it 'returns file name of deleted' do
      delete = f.delete_file('made_file.rb')
      expect(delete).not_to be(false)
    end
  end
end
