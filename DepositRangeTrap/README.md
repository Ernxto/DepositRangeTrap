# DepositRangeTrap

A Drosera-enabled deposit trap for the Hoodi Ethereum testnet:
- Refunds ETH deposits outside a defined range.
- Powered by decentralized Drosera automation.

## ✅ Getting Started

1. Rename .env.example to .env and fill in:
   - PRIVATE_KEY: Your testnet wallet private key.
   - DROSERA_OPERATOR: Your operator address
   - Hoodi_RPC_URL: Hoodi testnet RPC endpoint.
   - TARGET_ADDRESS: Fill after deployment.

2. Install dependencies:

```bash
npm install
```

3. Deploy RefundContract:

```bash
forge script script/DeployRefundContract.s.sol \
  --rpc-url $Hoodi_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```

4. Copy deployed address into .env and drosera.toml.

5. Fund the RefundContract with enough ETH for refunds:

```bash
cast send $TARGET_ADDRESS --value 1ether \
  --rpc-url $Hoodi_RPC_URL \
  --private-key $PRIVATE_KEY
```

6. Register the Drosera trap:

```bash
drosera apply
```

7. ✅ Test:
   - Send deposits < 0.01 ETH or > 1 ETH → get refunded.
   - Send valid deposits 0.01–1 ETH → left untouched.

---

## 🧪 Testing Logs

Use:

```bash
cast tx receipt <tx_hash> --rpc-url $Hoodi_RPC_URL
```

Or log transactions in Drosera Operator output.
