# frozen_string_literal: true

class Objects
  def initialize(options)
    @options = options
  end

  def object_list
    objects = if @options[:all]
                Dir.glob('*', File::FNM_DOTMATCH)
              else
                Dir.glob('*')
              end

    @options[:reverse] ? objects.sort.reverse : objects.sort
  end
end
