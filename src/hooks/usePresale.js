import { PRESALE } from "../config";
import presaleABI from "../abi/presale.json"
import { useReadContract, useReadContracts } from "wagmi";

export const presaleContractConfig = {
    address: PRESALE,
    abi: presaleABI
}

export const readPresaleContract = () => {
    return useReadContracts({
        contracts: [
            {
                ...presaleContractConfig,
                functionName: 'startTime',
            },
            {
                ...presaleContractConfig,
                functionName: 'endTime',
            },
            {
                ...presaleContractConfig,
                functionName: 'totalCAUAmount'
            }
        ],
    });
}

export const getAmount = ({ address }) => {
    return useReadContracts({
        contracts: [
            {
                ...presaleContractConfig,
                functionName: 'buyAmount',
                args: [address]
            },
            {
                ...presaleContractConfig,
                functionName: 'claimAmount',
                args: [address]
            },
        ],
    });
}