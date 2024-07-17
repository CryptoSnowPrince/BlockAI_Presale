import { Divider } from "@mui/material";

const HowTo = () => {
    return (
        <div className="px-4 w-full flex flex-col mt-[160px]">
            <div className="max-w-[572px] mx-auto flex flex-col">
                <div className="mx-auto flex flex-col gap-2 items-center">
                    <div className=" w-max rounded-3xl border border-solid border-green-800 px-3 py-1 flex flex-row gap-1">
                        <img src="/assets/icon/ic_stargroup.svg" />
                        <div className="font-medium">Buy Token</div>
                    </div>
                    <div className="text-[32px] md:text-[52px] leading-[62.4px] tracking-tighter">
                        How To Buy Token
                    </div>
                </div>
            </div>
            <div className="h-[490px] flex flex-row md:gap-[20px] lg:gap-[96px] justify-center mt-12">
                <div className="hidden md:flex flex-row items-center">
                    <div className="md:w-[240px] md:h-[240px] lg:w-[360px] lg:h-[360px]">
                        <img src="/assets/icon/ic_backforward.svg" />
                    </div>
                </div>
                <div className="w-full md:min-w-[410px] md:w-[410px] flex flex-row gap-5">
                    <div className="hidden md:flex flex-row gap-2 items-start">
                        <div className="flex flex-col gap-6 items-start">
                            <p className="mt-1 text-[12px] leading-[20px] font-medium">01.</p>
                            <p className="mt-[85px] text-[12px] leading-[20px] font-medium">02.</p>
                            <p className="mt-[62px] text-[12px] leading-[20px] font-medium">03.</p>
                            <p className="mt-[135px] text-[12px] leading-[20px] font-medium">04.</p>
                        </div>
                        <Divider orientation="vertical" />
                    </div>
                    <div className="h-fit  flex flex-col items-start">
                        <div className="flex flex-col gap-2 items-start">
                            <p className="text-xl leading-8 font-medium">Create a Wallet</p>
                            <p className="text-sm leading-[21px] text-left">Get any of your favorite wallet that can connects to Canxium Blockchain, Desktop Users, download Extension wallet to connect.
                            </p>
                        </div>
                        <div className="flex flex-col gap-2 items-start mt-6">
                            <p className="text-xl leading-8 font-medium">Get CAU!</p>
                            <p className="text-sm leading-[21px] text-left">Get or most hold CAU in your Wallet to exchange for <span className="text-[#06BDC5]">$BAI</span></p>
                        </div>
                        <div className="flex flex-col gap-2 items-start mt-6">
                            <p className="text-xl text-left leading-8 font-medium">Click Connect to BLOCK AI Token Platform Presale Section</p>
                            <p className="text-sm leading-[21px] text-left">Proceed to next step by Entering the amount of <span className="text-[#06BDC5]">$BAI</span> Token you wish to purchase. Our platform will send a pop up Transaction details including  current exchange token rate and any associate  fees for you to confirm from your wallet..</p>
                        </div>
                        <div className="flex flex-col gap-2 items-start mt-6">
                            <p className="text-xl leading-8 font-medium">Confirm The Pop-up Transaction</p>
                            <p className="text-sm leading-[21px] text-left">Review the transaction  details and verify  that everything is accurate. Once your satisfied confirm the transaction through your connected wallet. DONE and now Head to Claim section to claim your purchased presale <span className="text-[#06BDC5]">$BAI</span> Tokens!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default HowTo;