// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {BaseRegistrarImplementation as UpstreamBaseRegistrarImplementation} from "@ensdomains/ens-contracts/contracts/ethregistrar/BaseRegistrarImplementation.sol";
import {ENS} from "@ensdomains/ens-contracts/contracts/registry/ENS.sol";

/// @title BaseRegistrarImplementation
/// @notice Re-exports the upstream ENS base registrar with configurable ERC721 metadata URI support.
/// @dev Registrar behavior is inherited from upstream ENS; this contract only adds an owner-managed base URI consumed by OpenZeppelin `ERC721.tokenURI`.
/// @custom:security Base URI updates are owner-only and do not modify ownership, expiry, controller, or ENS registry state.
/// @custom:assumption The off-chain metadata endpoint accepts decimal registrar token ids appended to the configured base URI.
/// @custom:invariant Metadata configuration must not affect name availability, renewal, or reclaim semantics.
contract BaseRegistrarImplementation is UpstreamBaseRegistrarImplementation {
    /// @notice Emitted when the ERC721 metadata base URI changes.
    /// @param baseTokenURI The base URI concatenated with decimal token ids by `tokenURI`.
    event BaseTokenURIUpdated(string baseTokenURI);

    /// @notice The base URI used by `tokenURI` for live registrar ERC721 tokens.
    /// @dev Empty value preserves upstream behavior and returns an empty token URI.
    string public baseTokenURI;

    /// @notice Deploys the `.goat` base registrar.
    /// @dev The ERC721 metadata base URI starts empty and can be configured by the owner after deployment.
    /// @param ens_ The ENS registry.
    /// @param baseNode_ The namehash of the `.goat` TLD.
    constructor(
        ENS ens_,
        bytes32 baseNode_
    ) UpstreamBaseRegistrarImplementation(ens_, baseNode_) {}

    /// @notice Updates the ERC721 metadata base URI.
    /// @dev Access: owner only. External calls: none. The configured value is used only for off-chain metadata resolution.
    /// @param newBaseTokenURI The base URI concatenated with decimal token ids by `tokenURI`.
    function setBaseTokenURI(
        string calldata newBaseTokenURI
    ) external onlyOwner {
        baseTokenURI = newBaseTokenURI;
        emit BaseTokenURIUpdated(newBaseTokenURI);
    }

    /// @notice Returns the metadata URI for a live registrar ERC721 token.
    /// @dev Expired names are treated as nonexistent by calling `ownerOf` before delegating to OpenZeppelin URI construction.
    /// @param tokenId The registrar token id, equal to the uint256 labelhash.
    /// @return uri The configured base URI plus the decimal token id, or an empty string when no base URI is set.
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory uri) {
        ownerOf(tokenId);
        return super.tokenURI(tokenId);
    }

    /// @dev Supplies the owner-managed metadata base URI consumed by OpenZeppelin `ERC721.tokenURI`.
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
}
