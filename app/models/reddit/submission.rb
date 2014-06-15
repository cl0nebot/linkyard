class Reddit::Submission < Reddit::Response
  def self.parse_from(json)
    if json["json"] && json["json"]["submit"] 
      Submission.new()
    end
  end
end
