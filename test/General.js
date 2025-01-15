const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe.only('Art3Copyrights', function () {
    async function setup() {
        const [owner] = await ethers.getSigners();

        const Art3Tokens = await ethers.getContractFactory('Art3Tokens');
        const art3Tokens = await Art3Tokens.deploy("Ar3Tokens", "ART3");

        const Art3Copyrights = await ethers.getContractFactory('Art3Copyrights');
        const art3Copyrights = await Art3Copyrights.deploy("Art3Copyrigts", "COP3");

        return { art3Tokens, art3Copyrights, owner };
    }


    it('Returns token endTime', async function () {
        const { art3Tokens, art3Copyrights } = await loadFixture(setup);

        expect(parseInt(await art3Copyrights.startTime(0))).to.equal(0);
    });

    it('Returns token linked to tokenId', async function () {
        const { art3Tokens, art3Copyrights } = await loadFixture(setup);

        const res = await art3Copyrights.getLinkedToken(0);

        expect(res[0]).to.equal(0n);
        expect(res[1]).to.equal("0x0000000000000000000000000000000000000000");
    });

    it('Tries minting', async function () {
        const { art3Tokens, art3Copyrights, owner } = await loadFixture(setup);

        await art3Tokens.safeMint(owner.address, 0);
        await art3Copyrights.safeMint(owner.address, 0, art3Tokens.target, 0);

        const res = await art3Copyrights.getLinkedToken(0);

        expect(res[0]).to.equal(0n);
        expect(res[1]).to.equal(art3Tokens.target);
    });
});