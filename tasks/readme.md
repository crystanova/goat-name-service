# GNSPriceBook Tasks

These Hardhat tasks manage the deployed `GNSPriceBook` payment-token whitelist.

The tasks resolve the `GNSPriceBook` address through Hardhat Ignition's public APIs in `@nomicfoundation/ignition-core`, using the selected network's default Ignition deployment ID (`chain-<chainId>`), so you only need to provide the token and pricing parameters.

## `set-token-config`

This task reads `decimals()` from the target ERC20 and converts `--price-3`, `--price-4`, and `--price-5-plus` from whole-token values into the smallest token unit before calling `setTokenConfig`.

```sh
npx hardhat --network testnet3 gns-price-book set-token-config \
  --token 0xYourPaymentToken \
  --price-3 100 \
  --price-4 30 \
  --price-5-plus 3
```

Mainnet usage:

```sh
npx hardhat --network mainnet gns-price-book set-token-config \
  --token 0xYourPaymentToken \
  --price-3 100 \
  --price-4 30 \
  --price-5-plus 3
```

## `disable-token`

This task removes a token from the payment whitelist by calling `disableToken`.

```sh
npx hardhat --network testnet3 gns-price-book disable-token \
  --token 0xYourPaymentToken
```

Mainnet usage:

```sh
npx hardhat --network mainnet gns-price-book disable-token \
  --token 0xYourPaymentToken
```

## Notes

- The task resolves `GNSModule#GNSPriceBook` from the selected network's Ignition deployment via `listDeployments()` and `status()` from `@nomicfoundation/ignition-core`.
- `hardhat.config.ts` expects `GOAT_TESTNET3_DEPLOY_PRIVATE_KEY` for `testnet3`.
- `hardhat.config.ts` expects `GOAT_MAINNET_DEPLOY_PRIVATE_KEY` for `mainnet`.
- The caller must be the `owner` of the target `GNSPriceBook` contract.

## Testnet3 Tokens

```
TestUSDC - 0xFCA5846c86dC8Df1B1e21447649A08a18B667B92
TestUSDT - 0x030B2C744Fa080D97c0033214dEF6384f763aB21
```

## Mainnet Tokens

```
USDC.e - 0x3022b87ac063DE95b1570F46f5e470F8B53112D8
USDT - 0xE1AD845D93853fff44990aE0DcecD8575293681e
```

# GNSX402Adaptor Tasks

These Hardhat tasks manage the deployed `GNSX402Adaptor` authorized-caller list.

The task automatically reads the `GNSX402Adaptor` address from `ignition/deployments/chain-<chainId>/deployed_addresses.json` using the selected network's `chainId`.

## `set-authorized-caller`

This task calls `setAuthorizedCaller(caller, authorized)` on the deployed adaptor.

Authorize a caller on testnet3:

```sh
npx hardhat --network testnet3 gns-x402-adaptor set-authorized-caller \
  --caller 0xA58917dB2712F1c09D0078aeee1BA3ED8eD3565a
```

Revoke a caller on testnet3:

```sh
npx hardhat --network testnet3 gns-x402-adaptor set-authorized-caller \
  --caller 0xA58917dB2712F1c09D0078aeee1BA3ED8eD3565a \
  --authorized false
```

## Notes

- The task resolves `GNSModule#GNSX402Adaptor` from the Ignition deployment of the selected network.
- `hardhat.config.ts` expects `GOAT_TESTNET3_DEPLOY_PRIVATE_KEY` for `testnet3`.
- `hardhat.config.ts` expects `GOAT_MAINNET_DEPLOY_PRIVATE_KEY` for `mainnet`.
- The sender must be the `owner` of the target `GNSX402Adaptor` contract.
