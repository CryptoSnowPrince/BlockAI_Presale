import { mainnet, sepolia } from "viem/chains";
import { createConfig, http } from "wagmi";

export const config = createConfig({
  chains: [mainnet, sepolia],
  ssr: true,
  transports: {
    [mainnet.id]: http(),
    [sepolia.id]: http(),
  },
});

export const NETWORK_MODE = sepolia
export const TOKEN_DECIMAL = 18

export const TOKEN_PRESALE_HARDCAP = 22000

export const API_KEY = '3TEWVV2EK19S1Y6SV8EECZAGQ7W3362RCN'

export const ETH_PRICE_API = `https://api-sepolia.etherscan.io/api?module=stats&action=ethprice&apikey=${API_KEY}`

export const BAI_TOKEN = NETWORK_MODE === sepolia ? '0x45582d60Ace910e44b89Ee8c8f38913B97f0fA6f' : ""
export const PRESALE = NETWORK_MODE === sepolia ? '0xd64a25E50Ff448ef6f92c297309f81407f71fCC7' : ""

export const TOKEN_PRICE = 0.00055