import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { task } from 'hardhat/config';


task('deploy', 'Deploy the contract')
    .setAction(async (args, hre: HardhatRuntimeEnvironment) => {
        const factory = await hre.ethers.getContractFactory('Test');
        const contract = await factory.deploy();

        const dt = contract.deploymentTransaction();
        console.log('Transaction hash:', dt!.hash);

        await contract.waitForDeployment();

        console.log('Contract address:', await contract.getAddress());
    });