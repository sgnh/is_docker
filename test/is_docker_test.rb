# frozen_string_literal: true

require 'test_helper'

class IsDockerTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::IsDocker::VERSION
  end

  def test_that_it_returns_true_with_cgroup
    stub = proc { |args| ['docker'] if args == '/proc/self/cgroup' }

    File.stub(:readlines, stub) do
      assert IsDocker.docker? == true
    end
  end

  def test_that_it_returns_false_with_cgroup
    stub = proc { |args| [''] if args == '/proc/self/cgroup' }

    File.stub(:readlines, stub) do
      assert IsDocker.docker? == false
    end
  end

  def test_that_it_returns_false_without_cgroup
    stub = proc { |args|
      raise Errno::ENOENT if args == '/proc/self/cgroup'
    }

    File.stub(:readlines, stub) do
      assert IsDocker.docker? == false
    end
  end
end
