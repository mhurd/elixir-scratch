defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args([ "-h" ]) == :help
    assert parse_args([ "-h", "anything" ]) == :help
    assert parse_args([ "-h", "anything", "other", "foo" ]) == :help
    assert parse_args([ "--help" ]) == :help
    assert parse_args([ "--help", "anything" ]) == :help
    assert parse_args([ "--help", "anything", "other", "foo" ]) == :help
  end

  test "three values returned if three given" do
    assert parse_args([ "user", "project" , "99" ]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args([ "user", "project"]) == { "user", "project", 4 }
  end

end