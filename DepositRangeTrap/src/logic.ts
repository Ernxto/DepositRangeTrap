import { ethers } from "ethers";

export interface Deposit {
  sender: string;
  amount: ethers.BigNumber;
}

export async function collect(provider: ethers.providers.JsonRpcProvider): Promise<Deposit[]> {
  const block = await provider.getBlockWithTransactions("latest");
  const deposits = block.transactions.filter(tx =>
    tx.to?.toLowerCase() === process.env.TARGET_ADDRESS?.toLowerCase()
  );
  return deposits.map(tx => ({
    sender: tx.from,
    amount: ethers.BigNumber.from(tx.value)
  }));
}

export function shouldRespond(deposits: Deposit[]): [boolean, string] {
  const min = ethers.utils.parseEther("0.01");
  const max = ethers.utils.parseEther("1");

  for (const dep of deposits) {
    if (dep.amount.lt(min) || dep.amount.gt(max)) {
      const encoded = ethers.utils.defaultAbiCoder.encode(
        ["address", "uint256"],
        [dep.sender, dep.amount]
      );
      return [true, encoded];
    }
  }

  return [false, "0x"];
}