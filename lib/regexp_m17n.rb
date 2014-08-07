module RegexpM17N
  def self.non_empty?(str)
    # Both string and regexp are converted to unicode.
    str.encode("UTF-8") =~ /^.+$/u
  end
end