import "./pages.css"
import { getAmount, presaleContractConfig } from "../hooks/usePresale.js"
import {numberWithCommas} from "../utils"
import { TOKEN_DECIMAL } from "../config/index.js";
import { useEffect, useState } from "react";
import { useAccount, useWriteContract } from "wagmi";
import { Icon, IconType } from "../components/icons";
import { toast } from "react-toastify";

const Claim = () => {
    const { address } = useAccount();
    const { data: amount, isSuccess, isLoading } = getAmount({ address });
    const { data, error, isPending, isError, writeContract } = useWriteContract();

    const [buyAmount, setBuyAmount] = useState(0)
    const [claimedAmount, setClaimedAmount] = useState(0)

    useEffect(() => {
        if (amount) {
            setBuyAmount(Number(amount[0].result))
            setClaimedAmount(Number(amount[1].result))
        }
    }, [amount, isSuccess, isLoading])

    const onClaimToken = () => {
        if (buyAmount - claimedAmount <= 0) {
            toast.warning("Invalid claim amount");
            return;
        }

        writeContract({
            ...presaleContractConfig,
            functionName: "claimToken",
            args: [BigInt(buyAmount - claimedAmount)],
        })
    };

    useEffect(() => {
        console.log("pooh, error = ", error)
        if (isError) {
            toast.error(error)
        }
    }, [isError, error])

    return (
        <div className="w-full flex flex-col items-center mt-[160px]">
            <div className="w-full md:w-[503px] flex flex-col">
                <div className="font-normal text-[32px] md:text-[52px] leading-[62.4px] tracking-tight">
                    Claim your <span className="text-cyan-400">$BAI</span>
                </div>
                <div className="text-base tracking-tight mt-4">Claim your $BAI tokens today and unlock exclusive benefits soon.</div>
            </div>
            <div className="w-full md:w-[550px] border border-solid border-cyan-400 p-6 rounded-3xl flex flex-col mt-6">
                <div className="flex flex-col">
                    <p>Your claimable amount</p>
                    <div className='w-full h-0 border border-[#0a220b] mt-6'/>
                    <div className="h-[34px] flex flex-row items-center justify-center mt-6">
                        <img src="/assets/icon/ic_bai.svg" width={'34px'} />
                        <div className="text-2xl ml-2">{numberWithCommas(Number((buyAmount - claimedAmount)/(10 ** TOKEN_DECIMAL)).toFixed(2))}</div>
                    </div>
                </div>
                {isPending ? 
                    <div className="flex flex-row items-center justify-center mt-6">
                        <Icon type={IconType.LOADING} className="w-14 h-14" />
                    </div> : 
                    <button className="h-[36px] rounded-2xl bg-cyan-400 font-medium mt-6" onClick={onClaimToken}>Claim now</button>
                }
            </div>
        </div>
    );
}

export default Claim;