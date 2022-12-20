# frozen_string_literal: true

class Content
  def initialize(options)
    @options = options
  end

  def find_contents
    contents = if @options[:all]
                 Dir.glob('*', File::FNM_DOTMATCH)
               else
                 Dir.glob('*')
               end

    @options[:reverse] ? contents.sort.reverse : contents.sort
  end
end
