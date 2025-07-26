module overflow_bug::reward {
    use sui::tx_context::TxContext;

    public fun calculate_reward(multiplier: u256): u256 {
        let mask = 0xffffffffffffffff << 192;
        if (multiplier > mask) {
            0
        } else {
            multiplier << 64
        }
    }
}