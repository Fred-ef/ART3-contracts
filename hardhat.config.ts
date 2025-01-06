import { HardhatUserConfig } from 'hardhat/types';
import '@nomicfoundation/hardhat-toolbox';
import '@oasisprotocol/sapphire-hardhat';
require('dotenv').config();

import './tasks/deploy';

const TEST_HDWALLET = {
    mnemonic: 'test test test test test test test test test test test junk',
    initialIndex: 0,
    count: 20,
    path: "m/44'/60'/0'/0",
    passphrase: '',
};

const accounts = process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : TEST_HDWALLET;

const config: HardhatUserConfig = {
    solidity: {
        version: '0.8.19',
        settings: {
            optimizer: {
                enabled: true,
                runs: 200,
            },
        },
    },
    networks: {
        hardhat: {
            chainId: 1337,
        },
        hardhat_local: {
            url: 'http://127.0.0.1:8545',
        },
        'sapphire': {
            url: 'http://sapphire.oasis.io',
            chainId: 0x5afe,
            accounts,
        },
        'sapphire-testnet': {
            url: 'https://testnet.sapphire.oasis.dev',
            chainId: 0x5aff,
            accounts,
        },
        'sapphire-localnet': {
            url: 'http://localhost:8545',
            chainId: 0x5afd,
            accounts,
        },
    },
};

export default config;