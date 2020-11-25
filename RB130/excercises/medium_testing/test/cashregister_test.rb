require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!

require_relative "cashregister.rb"
require_relative "transaction.rb"

class CashRegisterTest < Minitest::Test
  # Class needs to inherit from Minitest::Test to be a testing class

  def setup
    @register = CashRegister.new(1000)
    @transaction = Transaction.new(100)
  end

  def test_accept_money
    # Problem: assumes set-up will be static. If it changes, it breaks the test
    @transaction.amount_paid = 200
    assert_equal(1200, @register.accept_money(@transaction))
  end

  def test_accept_money
    @transaction.amount_paid = 200
    before = @register.total_money
    @register.accept_money(@transaction)

    assert_equal(before + @transaction.amount_paid, @register.total_money)
  end

  def test_change
    local_transaction = Transaction.new(100)
    local_transaction.amount_paid = 200

    assert_equal(100, @register.change(local_transaction))
  end

  def test_give_receipt
    local_transaction = Transaction.new(100)
    assert_output("You've paid $100.\n") { @register.give_receipt(local_transaction) }
  end

  def test_prompt_for_payment
    local_transaction = Transaction.new(100)
    assert_output("You owe $#{item_cost}.\nHow much are you paying?") { @register.give_receipt(local_transaction) }
  end
end
