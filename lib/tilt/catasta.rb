require 'tilt/template'

module Tilt
  # Haml template implementation. See:
  # http://haml.hamptoncatlin.com/
  class CatastaTemplate < Template
    self.default_mime_type = 'text/html'

    def self.engine_initialized?
      defined? ::Catasta
    end

    def initialize_engine
      require_template_library 'catasta'
    end

    def prepare
      @engine = ::Catasta::App.new(targets: ["Ruby"], tilt: true)
    end

    def precompiled(locals)
      result = @engine.go(data, nil)
      assignments = "_params = locals"
      result = [assignments, result].join("\n")
      [result, 0]
    end
  end
end

