class FileManagementErrors < StandardError
  def initialize(message)
    super(message)
  end
end
