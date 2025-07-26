module object_management_bug::profile {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;
    use sui::transfer;

    struct UserProfile has key, store {
        id: UID,
        balance: u64
    }

    public fun update_profile(profile: UserProfile, new_balance: u64, ctx: &mut TxContext) {
        let updated = UserProfile {
            id: profile.id,
            balance: new_balance
        };
        transfer::share_object(updated);
    }
}