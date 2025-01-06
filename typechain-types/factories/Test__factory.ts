/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type { Signer, ContractDeployTransaction, ContractRunner } from "ethers";
import type { NonPayableOverrides } from "../common";
import type { Test, TestInterface } from "../Test";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_value",
        type: "uint256",
      },
    ],
    name: "setValue",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "value",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b5060408051808201909152601981527f4465706c6f79696e672061205465737420636f6e747261637400000000000000602082015261004e90610058565b600f600055610124565b61009f8160405160240161006c91906100d6565b60408051601f198184030181529190526020810180516001600160e01b0390811663104c13eb60e21b179091526100a216565b50565b61009f816100b560201b6100631760201c565b60006a636f6e736f6c652e6c6f679050600080835160208501845afa505050565b600060208083528351808285015260005b81811015610103578581018301518582016040015282016100e7565b506000604082860101526040601f19601f8301168501019250505092915050565b60f0806101326000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c80633fa4f24514603757806355241077146051575b600080fd5b603f60005481565b60405190815260200160405180910390f35b6061605c366004608c565b600055565b005b60006a636f6e736f6c652e6c6f679050600080835160208501845afa505050565b608a60a4565b565b600060208284031215609d57600080fd5b5035919050565b634e487b7160e01b600052605160045260246000fdfea264697066735822122030de43cfe0dc3ce07ba82d7738a834bc922e6ee05c26a12b46f9c8460fbfdf9164736f6c63430008130033";

type TestConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: TestConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Test__factory extends ContractFactory {
  constructor(...args: TestConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(overrides || {});
  }
  override deploy(overrides?: NonPayableOverrides & { from?: string }) {
    return super.deploy(overrides || {}) as Promise<
      Test & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): Test__factory {
    return super.connect(runner) as Test__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TestInterface {
    return new Interface(_abi) as TestInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): Test {
    return new Contract(address, _abi, runner) as unknown as Test;
  }
}
