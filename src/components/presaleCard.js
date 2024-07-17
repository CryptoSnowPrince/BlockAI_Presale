import React, { useState, useContext, useEffect, useCallback } from "react";
import {
    useWallet,
  } from "@solana/wallet-adapter-react";
import PrePayInput from "./prePayInput"
import PreReceiveInput from "./preReceiveInput"
import Stats from "../components/stats.js"
import { Icon, IconType } from "./icons";

import { toast } from "react-toastify";

import "./components.scss"
import CountItem from "./countItem"

import Countdown from "react-countdown";
import ThemeContext from '../context/themeContext';
import { useAccount, useWriteContract } from "wagmi";
import { getETHBalance } from "../hooks/useToken.js";
import { TOKEN_PRICE } from "../config/index.js";
import { readPresaleContract, presaleContractConfig } from "../hooks/usePresale.js";

const PresaleCard = () => {
    const { address } = useAccount();
    const { data, error, isPending, isError, writeContract } = useWriteContract();

    const { data: ethBalance, refetch } = getETHBalance({ address });
    const { data: presaleInfo , isSuccess, isLoading } =  readPresaleContract()

    const [quoteAmount, setQuoteAmount] = useState(0);
    const [tokenAmount, setTokenAmount] = useState(0);
    const [ratio, setRatio] = useState(TOKEN_PRICE)
    const [canBuy, setCanBuy] = useState(true);

    const [startTime, setStartTime] = useState(0)
    const [endTime, setEndTime] = useState(0)
    const [totalCAUAmount, setTotalCAUAmount] = useState(0)
    
    useEffect(() => {
        const current = Date.now();
        if (presaleInfo) {
            setStartTime(Number(presaleInfo[0].result))
            setEndTime(Number(presaleInfo[1].result))
            setTotalCAUAmount(Number(presaleInfo[2].result))
            if (presaleInfo?.startTime < current && presaleInfo?.endTime > current) {
                setCanBuy(true);
            } else {
                setCanBuy(false);
            }
        }
    }, [presaleInfo, isSuccess, isLoading]);

    useEffect(() => {
        setTokenAmount(quoteAmount / ratio)
    }, [quoteAmount, ratio])

    const onBuyToken = () => {
        if (ethBalance < quoteAmount) {
            toast.warning("Please check balance again.");
            return;
        }
        writeContract({
            ...presaleContractConfig,
            functionName: "buyTokensByETH",
            args: [BigInt(quoteAmount)],
        })
    };


    return (
        <div className="w-full md:w-[407px] rounded-3xl p-6 border border-solid border-[#68F2C9] flex flex-col mt-[50px] lg:ml-[50px] xl:ml-[206px]">
            <div className="w-full md:w-[359px] flex flex-col">
                <div className="text-[14px] leading-[17px] tracking-wide uppercase text-left">
                    {Date.now() < startTime * 1000 && "Pre-Sale Starts In"}
                    {Date.now() >= startTime * 1000 && Date.now() < endTime * 1000 && "Pre-Sale Ends In"}
                    {Date.now() > endTime * 1000 && ""}
                </div>
                {endTime ? Date.now() < endTime * 1000 ? (
                    <Countdown
                        date={
                            Date.now() < startTime * 1000 ? startTime * 1000 : endTime * 1000
                        }
                        renderer={renderer}
                    />
                ) : (
                    <span className="text-3xl font-bold text-[#d00711]">
                        Presale Completed.
                    </span>
                ):<span className="text-3xl font-bold text-[#00CABE]">
                    Please connect your wallet.
                </span> 
                }
                <div className="w-full h-0 border-[0.5px] border-[#587267] mt-4" />
                <Stats raisedAmount={totalCAUAmount} />
                <div className="w-full h-0 border border-[#587267] mt-4" />
                <PrePayInput
                    title="Amount you pay"
                    value={quoteAmount}
                    setValue={(val) => setQuoteAmount(val)}
                />
                <PreReceiveInput 
                    title="Amount you receive"
                    value={tokenAmount}
                    setValue={(val) => setTokenAmount(val)}
                />
                <div className="flex flex-col mt-4">
                    <div className="w-full h-0 border border-[#587267]" />
                    <div className="flex flex-row items-center justify-center text-[14px] font-normal leading-[16.94px] mt-2.5">
                        <div className="flex flex-row items-center mr-2">
                            <img src='/assets/icon/ic_bai.svg' className="mr-1 w-5"/>
                            <span>1 BAI</span>
                        </div>
                        =
                        <div className="flex flex-row items-center ml-2">
                            <img src='/assets/img/cau.svg' className="w-4" />
                            <span className="ml-1">{ratio} CAU</span>
                        </div>
                    </div>
                </div>
            </div>
            {(canBuy && !isPending) && (
                <button
                    className="w-full h-9 flex flex-row items-center justify-center rounded-3xl px-4 py-2 text-[14px] bg-cyan-500 mt-5"
                    onClick={onBuyToken}
                >
                    Buy Now
                </button>
            )}
            {(canBuy && isPending) && 
                <div className="flex flex-row items-center justify-center mt-5">
                    <Icon type={IconType.LOADING} className="w-9 h-9" />
                </div>
            }
            {!canBuy && (
                <button
                    className="w-full h-9 flex flex-row items-center justify-center rounded-3xl px-4 py-2 text-[14px] bg-cyan-500 mt-5 cursor-not-allowed"
                    disabled
                >
                    Buy Now
                </button>
            )}
        </div>
    )
}

const renderer = ({
    days,
    hours,
    minutes,
    seconds,
    completed,
}) => {
    if (completed) {
        // Render a completed state
        return <Completionist />;
    } else {
        // Render a countdown
        return (
            <div className="flex flex-row justify-between mt-4">
                <CountItem title="DAYS" value={`${days>=10?days.toString():'0' + days.toString()}`}></CountItem>
                <div className="flex flex-row items-center text-[32px] font-normal leading-[38.73px]">:</div>
                <CountItem title="HRS" value={`${hours>=10?hours.toString():'0' + hours.toString()}`}></CountItem>
                <div className="flex flex-row items-center text-[32px] font-normal leading-[38.73px]">:</div>
                <CountItem title="MIN" value={`${minutes>=10?minutes.toString():'0' + minutes.toString()}`}></CountItem>
                <div className="flex flex-row items-center text-[32px] font-normal leading-[38.73px]">:</div>
                <CountItem title="SEC" value={`${seconds>=10?seconds.toString():'0' + seconds.toString()}`}></CountItem>
            </div>
        );
    }
};

export default PresaleCard;