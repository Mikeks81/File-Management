require 'fileutils'
require 'filesize'

class FileManager
  attr_accessor :path
  attr_reader :excludes
  def initialize(options = {})
    @path = options[:path] || './'
    @excludes = options[:excludes] || ''
    resolve_path(@path)
    options.each do |k,v|
      if k != :path && k != :excludes
        instance_variable_set('@' + k.to_s, v)
        add_accessor(k)
      end
    end
  end

  def excludes=(value)
    if value.nil? || value.class == Integer
      raise FileManagementErrors.new('Invalid value for @excludes')
    else
      @excludes = value
    end
  end

  def pwd(file)
    "#{path}/#{file}"
  end

  def format_excludes
    return excludes.split(' ') if excludes.class == String
    excludes
  end

  def all_files
    file_list = Dir.entries(path).select { |f| File.file?("#{path}/#{f}") }
    file_list - (%w(. .. .DS_Store file_management.rb) + format_excludes)
  end

  def file_exists?(file)
    all_files.include?(file)
  end

  def stats(file, request)
    raise FileManagementErrors.new('File doesn\'t exist') unless file_exists?(file)
    File.stat(pwd(file)).send(request)
  end

  def file_size(file)
    return false unless file_exists?(file)
    Filesize.new(File.size(pwd(file)), Filesize::SI).pretty
  end

  def make_file(file)
    return false if file_exists?(file)
    FileUtils.touch(pwd(file))
  end

  def url_sanitize(file_name)
    fn = file_name.split(/(?<=.)\.(?=[^.])(?!.*\.[^.])/m)
    fn.map! { |s| s.gsub(/[^a-z0-9\-]+/i, '_') }
    return fn.join '.'
  end

  def save_file(file, file_name)
    if !file_exists?(file_name)
      puts "^^^^^^^^ STARTING UPLOAD of #{file_name} ^^^^^^^^^^^^^^"
      File.open(pwd(file_name), 'wb') do |f|
        f.write(file.read)
      end
      puts "^^^^^^^^ FINISHED UPLOAD of #{file_name} ^^^^^^^^^^^^^^"
      file_exists?(file_name)
    else
      puts "^^^^^^^^^^ existing file ^^^^^^^^^^^^^^^^^^^^^^"
      "File already exists."
    end
  end

  def copy_file(src)
    file_name = File.split(src).last
    return false if file_exists?(file_name)
    FileUtils.cp(src, pwd(file_name))
  end

  def rename(file, new_name)
    return false if file_exists?(new_name) || !file_exists?(file)
    File.rename(pwd(file), pwd(new_name))
  end

  def delete_file(file)
    return false unless file_exists?(file)
    FileUtils.rm(pwd(file))
  end

  private

  def add_accessor(name)
    self.class.send(:attr_accessor, name)
  end

  def resolve_path(path)
    FileUtils.mkdir_p(path.split)
    raise FileManagementErrors.new('Directory could not be created') unless File.directory?(path)
  end
end
