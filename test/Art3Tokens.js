const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe.only('Art3Tokens', function () {
    async function setup() {
        const [owner] = await ethers.getSigners();

        const Art3Tokens = await ethers.getContractFactory('Art3Tokens');
        const art3Tokens = await Art3Tokens.deploy("Ar3Tokens", "ART3");

        return { art3Tokens, owner };
    }


    it('Should return the royalty fee in basis point for the sale price provided', async function () {
        const { art3Tokens } = await loadFixture(setup);

        expect(parseInt(await art3Tokens.royaltyFeeNumerator(250000))).to.equal(280);
    });

    it('Should return the royalty fee in euros for the sale price provided', async function () {
        const { art3Tokens } = await loadFixture(setup);

        const royaltyInfo = await art3Tokens.royaltyInfo(1, 250000);

        expect(parseInt(royaltyInfo[1])).to.equal(7000);
    });
});