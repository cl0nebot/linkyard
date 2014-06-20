class Reddit::Submission < Reddit::Response
  def self.parseable?(data)
    puts data
    false
  end
end
