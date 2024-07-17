import "./layouts.css"
import { useAccount } from 'wagmi'
import { WalletOptions } from "./wallet-options";
import { Account } from "./account";
import { useSwitchChain } from 'wagmi'
import { NETWORK_MODE } from "../config";

const ChangeNetwork = () => {
    const { chains, switchChain } = useSwitchChain()
    return (        
        <div className="h-9 flex flex-row items-center justify-center rounded-3xl px-4 py-2 text-[12px] bg-cyan-500 cursor-pointer">
            <button key={NETWORK_MODE.id} onClick={() => switchChain({ chainId: NETWORK_MODE.id })}>
                Change {NETWORK_MODE.name} network
            </button>
        </div>
    )
}

const Navbar = () => {
    const ConnectWallet = () => {
        const { isConnected, chainId } = useAccount()
        if (isConnected) {
            if (chainId !== NETWORK_MODE.id) {
                return <ChangeNetwork />
            } else {
                return <Account />
            }
        } else {
            return <WalletOptions />
        }
    }

    return (
        <div className="mx-4 md:mx-[40px] lg:mx-[160px] h-[80px]  flex flex-row gap-2 items-center justify-between z-50">
            <div className="w-[200px] h-10 flex flex-row items-center gap-2.5">
                <img className="w-6" src="/assets/icon/ic_bai.svg" />
                <p className="text-xl font-semibold">Block AI <span className="text-sky-700">Platform</span></p>
            </div>
            <ConnectWallet />
        </div>
    );
}

export default Navbar;