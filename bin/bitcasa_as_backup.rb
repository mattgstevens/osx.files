# build exclude file: rysync_excludes/.template && .gitignore files that are found in dir tree

# perform rsync

# encrypt?

# notify of sync

module Backup
  class BitCasa
    class << self

      def default_config
        {
          from: "~/workspace",
          to: "/Volumes/Bitcasa Infinite Drive",
          exclude_resources: ['.gitignore'],
          exclude_template: "~/rsync_excludes/.template"
        }
      end

      def go!(user_config={})
        @data = default_config.merge normalize_config(user_config)

        exclude_set = build_exclude_files
        full_set = discover_directory_tree(exclude_set)

        # exclude_set.each { |dir| puts dir }
        full_set.each { |dir| puts dir }
        # rsync @data[:from], @data[:to], build_exclude_file
      end

    private

      def discover_directory_tree(excluded=[])
        require 'find'

        Find.find(@data[:from]) do |path|
          if FileTest.directory?(path) && excluded.index(path) == nil

          end
        end

        Dir.glob('*').inject([]) do |rv, nfa|
          if FileTest.directory?(nfa) && excluded.index(nfa) == nil
            rv << nfa
          end
          rv
        end
      end

      def build_exclude_files
        find_files_like(@data[:exclude_resources]).each do |file|
          puts file
        end
      end

      def normalize_config(config)
        config.inject({}) { |result, (k, v)| result.store(k.to_sym, v); result }
      end

      def find_files_like(file_set)
        file_set.inject([]) do |rv, file|
          rv += `find . -name #{file}`.split("\n")
        end
      end

      def rsync(from, to, exclude_file)
        `rsync -rt -v --delete --delete-excluded --delete-after #{from} #{to} --exclude-from #{exclude_file}`
      end

    end
  end
end

Backup::BitCasa.go!
