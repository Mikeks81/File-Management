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
    it 'creates file in correct path and returns filename'

    it 'does not create file that exists'
  end

  describe 'all_files' do
    it 'should list all files in path not in excludes'

    it 'should return an array'
  end

  describe 'pwd' do
    it 'returns string with initialized path'
  end

  describe 'stats' do
    it 'returns false if file doesn\'t exist'

    it 'should return File::Stat object'
      # f.stat(file, 'class')
      # expect(f).to eq(File::Stat)
  end

  describe 'file_size' do
    it 'should return false is file does not exist'

    it 'should return string if file does exist'
  end

  describe 'file_exists?' do
    it 'returns true if file exists'
    it 'returns false if file doesn\'t exist'
  end

  describe 'rename' do
    it 'returns false if file doesn\'t exist'

    it 'returns false if new_name exists'

    it 'returns filename if file is renamed'
  end

  describe 'delete_file' do
    it 'returns false if file doesn\'t exist'
    it 'returns file name of deleted'
  end
end
