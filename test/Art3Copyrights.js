const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Art3Copyrights', function () {
    async function setup() {
        const [owner] = await ethers.getSigners();

        const Art3Copyrights = await ethers.getContractFactory('Art3Copyrights');
        const art3Copyrights = await Art3Copyrights.deploy("Art3Copyrigts", "COP3");

        return { art3Copyrights, owner };
    }


    it('Returns token endTime', async function () {
        const { art3Copyrights } = await loadFixture(setup);

        console.log(await art3Copyrights.endTime(0));

        // expect(parseInt(await art3Copyrights.startTime(0))).to.equal(280);
    });

    it('Returns token linked to tokenId', async function () {
        const { art3Copyrights } = await loadFixture(setup);

        console.log(await art3Copyrights.getLinkedToken(0));
    });

    it('Tries minting', async function () {
        const { art3Copyrights, owner } = await loadFixture(setup);

        console.log(await art3Copyrights.safeMint(owner.address, 0, 0x0, 0));
    });
});