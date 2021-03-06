# frozen_string_literal: true

module ObsDeploy
  module CLI
    module Commands
      class Deploy < Dry::CLI::Command
        desc 'Deploy obs-api'

        option :user, type: :string, default: 'root', desc: 'User'
        option :dry_run, type: :boolean, default: true, desc: 'Dry run'
        option :host, type: :string, default: 'localhost', desc: 'Set the server address'
        option :port, type: :int, default: 22, desc: 'Set the server port'

        def call(user:, dry_run:, host:, port:, **)
          ssh_driver = ObsDeploy::SSH.new(user: user, server: host, port: port)
          zypper = ObsDeploy::Zypper.new(dry_run: dry_run)
          ssh_driver.run(zypper.update)
        end
      end
    end
  end
end
