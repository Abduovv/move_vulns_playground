module arithmetic_bug::fee {
    use sui::tx_context::TxContext;

    public fun calculate_fee(amount: u64, percentage: u64): u64 {
        (amount * percentage) / 100
    }
}