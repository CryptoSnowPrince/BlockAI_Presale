import { BAI_TOKEN } from '../config'
import baiABI from '../abi/bai.json'
import { useBalance, useReadContract } from 'wagmi'

export const tokenContractConfig = {
    address: BAI_TOKEN,
    abi: baiABI
}

export const getETHBalance = ({ address }) => {
    return useBalance({ address })
}

export const getTokenBalance = ({ address }) => {
    return useReadContract({
        ...tokenContractConfig,
        functionName: 'balanceOf',
        args: [address]
    });
}