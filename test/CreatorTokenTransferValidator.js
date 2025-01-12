const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe.only('CreatorTokenTransferValidator', function () {
    async function setup() {
        const [owner] = await ethers.getSigners();

        const CreatorTokenTransferValidator = await ethers.getContractFactory('CreatorTokenTransferValidator');
        const creatorTokenTransferValidator = await CreatorTokenTransferValidator.deploy(owner.address);

        return { creatorTokenTransferValidator, owner };
    }


    it('should deploy and determine that the contract deployer is the owner of the whitelist 1', async function () {
        const { creatorTokenTransferValidator, owner } = await loadFixture(setup);

        expect(await creatorTokenTransferValidator.getOwnerOfOperatorWhitelist(1)).to.equal(owner.address);
    });

    it('should deploy and determine that the contract deployer is not a whitelisted operator', async function () {
        const { creatorTokenTransferValidator, owner } = await loadFixture(setup);

        expect(await creatorTokenTransferValidator.isOperatorWhitelisted(1, owner.address)).to.equal(false);
    });

    it('should deploy, add the deployer to the operators of the whiteslist 1 and check', async function () {
        const { creatorTokenTransferValidator, owner } = await loadFixture(setup);

        await creatorTokenTransferValidator.addOperatorToWhitelist(1, owner.address);
        expect(await creatorTokenTransferValidator.isOperatorWhitelisted(1, owner.address)).to.equal(true);
    });
});