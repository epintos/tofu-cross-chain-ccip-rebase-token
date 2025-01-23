-include .env

.PHONY: all test deploy

build :; forge build

test :; forge test

test-fork-sepolia :; @forge test --fork-url $(SEPOLIA_RPC_URL)

install :
	forge install foundry-rs/forge-std@v1.9.5 --no-commit && \
	forge install smartcontractkit/ccip@v2.17.0-ccip1.5.16 --no-commit && \
	forge install openzeppelin/openzeppelin-contracts@v5.2.0 --no-commit && \
	forge install smartcontractkit/chainlink-local@7d8b2f888e1f10c8841ccd9e0f4af0f5baf11dab --no-commit

deploy-sepolia :
	@forge script script/DeployMATE.s.sol:DeployMATE --rpc-url $(SEPOLIA_RPC_URL) --account $(SEPOLIA_ACCOUNT) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-anvil :
	@forge script script/DeployMATE.s.sol:DeployMATE --rpc-url $(RPC_URL) --account $(ANVIL_ACCOUNT) --broadcast -vvvv

fund-account :
	cast send $(SEPOLIA_ACCOUNT_ADDRESS) --value 0.01ether --rpc-url $(RPC_URL) --account $(ANVIL_ACCOUNT)
