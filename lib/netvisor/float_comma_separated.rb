class FloatCommaSeparated
  def self.parse(value)
    return 0 if value.nil? || value.empty?

    value.to_s.gsub(',', '.').to_f
  end
end
