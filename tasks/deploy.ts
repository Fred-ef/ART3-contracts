import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { task } from 'hardhat/config';


task('deploy', 'Deploy the contract').setAction(async (args, hre: HardhatRuntimeEnvironment) => {
    const factory = await hre.ethers.getContractFactory('CreatorTokenTransferValidator');   
    const contract = await factory.deploy("0xc0623607E160d6a7247ddC70481c1d0583Ee7766");

    const dt = contract.deploymentTransaction();
    console.log('Transaction hash:', dt!.hash);

    await contract.waitForDeployment();

    console.log('Contract address:', await contract.getAddress());
});