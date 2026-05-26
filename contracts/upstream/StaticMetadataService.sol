// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IMetadataService} from "@ensdomains/ens-contracts/contracts/wrapper/IMetadataService.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title StaticMetadataService
/// @notice Stores the metadata URI template used for every wrapped token.
/// @dev Access: the owner can update the URI template without changing the wrapper's metadata service address.
/// @custom:security Owner authority controls off-chain metadata resolution for all wrapped tokens.
/// @custom:assumption The off-chain metadata endpoint understands the configured URI template.
/// @custom:invariant All token ids resolve to the same configured URI template.
contract StaticMetadataService is IMetadataService, Ownable {
    /// @notice Emitted when the wrapped-token metadata URI template changes.
    /// @param metadataUri The new URI template returned for every token id.
    event MetadataURISet(string metadataUri);

    string private _uri;

    /// @notice Deploys the static metadata service.
    /// @dev The deploying account becomes owner and can later update the URI.
    /// @param metadataUri The metadata URI template returned for every wrapped token.
    constructor(string memory metadataUri) {
        _uri = metadataUri;
    }

    /// @notice Updates the metadata URI template returned for wrapped tokens.
    /// @dev Access: owner only. External calls: none. Empty strings are allowed to intentionally disable metadata resolution.
    /// @param metadataUri The new URI template returned for every token id.
    function setURI(string calldata metadataUri) external onlyOwner {
        _uri = metadataUri;

        emit MetadataURISet(metadataUri);
    }

    /// @notice Returns the configured metadata URI template for a wrapped token.
    /// @dev The token id is ignored because this service intentionally returns a single static template for all wrapped tokens.
    /// @param tokenId The wrapped token id being resolved.
    /// @return metadataUri The configured URI template.
    function uri(
        uint256 tokenId
    ) external view override returns (string memory metadataUri) {
        tokenId;

        return _uri;
    }
}
