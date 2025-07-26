module access_control_bug::vault {
    use sui::object::{Self, UID};
    use sui::tx_context::TxContext;

    struct Vault has key, store {
        id: UID,
        balance: u64
    }

    public fun update_balance(vault: &mut Vault, new_balance: u64, _ctx: &mut TxContext) {
        vault.balance = new_balance;
    }
}