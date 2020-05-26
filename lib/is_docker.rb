# frozen_string_literal: true

require 'is_docker/version'

module IsDocker
  def self.docker?
    begin
      !File.readlines('/proc/self/cgroup').grep(/docker/).empty?
    rescue Errno::ENOENT
      false
    end
  end
end
