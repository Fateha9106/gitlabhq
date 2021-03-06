# frozen_string_literal: true

module Gitlab
  module Ci
    module Build
      module Policy
        class Changes < Policy::Specification
          def initialize(globs)
            @globs = Array(globs)
          end

          def satisfied_by?(pipeline, seed)
            return true if pipeline.modified_paths.nil?

            pipeline.modified_paths.any? do |path|
              @globs.any? do |glob|
                File.fnmatch?(glob, path, File::FNM_PATHNAME | File::FNM_DOTMATCH | File::FNM_EXTGLOB)
              end
            end
          end
        end
      end
    end
  end
end
