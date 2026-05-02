# Agent Instructions

This repository is a Hardhat 3 project. It uses the native Node.js test runner
(`node:test`) and `viem` for Ethereum interactions.

## Project Overview

- Hardhat configuration lives in `hardhat.config.ts`.
- Solidity contracts live under `contracts/`.
- TypeScript integration tests use `node:test` and `viem`.
- Keep changes scoped to the requested behavior and follow existing project
  patterns before adding new abstractions.

## Commands

Run tests with:

```shell
npm test
```

Do not run `npm run compile` separately before `npm test`; the test command
already compiles the contracts.

Compile-only command, when explicitly needed:

```shell
npm run compile
```

Format Solidity before committing:

```shell
npm run fmt
```

Always run `npm run fmt` before committing Solidity changes.

## Solidity Commenting Guidelines

Comments should improve readability, auditability, and maintainability. Explain
why the code exists, which assumptions it depends on, and which security
constraints matter. Do not restate what the code already says.

### Required Rules

- Keep comments accurate when code changes.
- Explain "why", not "what".
- Add NatSpec for every public surface:
  - contracts
  - interfaces
  - libraries
  - public and external functions
  - events
  - errors
  - modifiers
- Document security assumptions explicitly, including:
  - access control
  - external calls
  - accounting and rounding
  - upgradeability
  - `unchecked`
  - `assembly`
- Do not leave commented-out code. Use Git history instead.
- TODOs must be actionable and should include an issue or PR reference when
  possible.

### NatSpec Template

```solidity
/// @title <Name>
/// @notice <User-facing summary>
/// @dev <Constraints and security notes>
/// @custom:security <Security assumptions>
/// @custom:assumption <Operational assumptions>
/// @custom:invariant <Invariant that must hold>
contract X {
    /// @notice <Verb phrase describing user-visible behavior>
    /// @dev Access: ... External calls: ... Rounding: ...
    /// @param p ...
    /// @return r ...
    function f(...) external returns (...) {}
}
```
