module race_condition_bug::reward_pool {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use sui::coin::{Self, Coin};

    struct Pool has key, store {
        id: UID,
        reward: u64
    }

    public fun claim_reward(pool: &mut Pool, ctx: &mut TxContext): Coin {
        let amount = pool.reward;
        assert!(amount > 0, 0);
        pool.reward = 0;
        coin::mint(amount, ctx)
    }
}