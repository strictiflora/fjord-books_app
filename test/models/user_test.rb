# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test '#name_or_email' do
    assert_equal 'alice@example.com', @alice.name_or_email

    @alice.name = 'Alice'
    assert_equal 'Alice', @alice.name_or_email
  end

  test '#follow' do
    assert_not @alice.following?(@bob)
    @alice.follow(@bob)
    assert @alice.following?(@bob)
  end

  test '#unfollow' do
    @alice.follow(@bob)
    @alice.unfollow(@bob)
    assert_not @alice.following?(@bob)
  end

  test '#following?' do
    @alice.follow(@bob)
    assert @alice.following?(@bob)
  end

  test '#followed_by?' do
    @alice.follow(@bob)
    assert @bob.followed_by?(@alice)
  end
end
