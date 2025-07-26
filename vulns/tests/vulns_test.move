module tests::VulnTests {
    use sui::test_scenario;
    use sui::tx_context::{TxContext, Self};
    use sui::coin;
    use sui::object;
    use std::string;

    use access_control_bug::vault::{Vault, update_balance};
    use arithmetic_bug::fee::calculate_fee;
    use object_management_bug::profile::{UserProfile, update_profile};
    use overflow_bug::reward::calculate_reward;
    use race_condition_bug::reward_pool::{Pool, claim_reward};

    fun create_uid(ctx: &mut TxContext): object::UID {
        object::new(ctx)
    }

    #[test]
    fun test_access_control_bug(ctx: &mut TxContext) {
        let id = create_uid(ctx);
        let mut vault = Vault { id, balance: 100 };
        update_balance(&mut vault, 1_000_000, ctx); // No access control — anyone can call this
        assert!(vault.balance == 1_000_000, 0);
    }

    #[test]
    fun test_arithmetic_bug(_: &mut TxContext) {
        let amount = 1_000_000_000_000u64;
        let percentage = 10_000u64; // 10,000%
        let fee = calculate_fee(amount, percentage); // overflows silently
        // this test won't fail but illustrates lack of overflow checks
        assert!(fee > 0, 0);
    }

    #[test]
    fun test_object_management_bug(ctx: &mut TxContext) {
        let id = create_uid(ctx);
        let profile = UserProfile { id, balance: 100 };
        update_profile(profile, 500, ctx); // old profile lost if not deleted properly
        // no assert here since transfer::share_object has no return
    }

    #[test]
    fun test_overflow_bug(_: &mut TxContext) {
        let large_multiplier: u256 = 1 << 200;
        let reward = calculate_reward(large_multiplier);
        // reward should be zero due to masking logic
        assert!(reward == 0, 0);
    }

    #[test]
    fun test_race_condition_bug(ctx: &mut TxContext) {
        let id = create_uid(ctx);
        let mut pool = Pool { id, reward: 10_000 };
        let _reward1 = claim_reward(&mut pool, ctx); // This succeeds
        // simulate second call (in real exploit: from concurrent tx)
        let success = std::option::is_some(&std::option::from_fn(|| claim_reward(&mut pool, ctx)));
        assert!(!success, 1); // Should fail second time as reward is now 0
    }
}
