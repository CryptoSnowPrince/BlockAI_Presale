const Dive = () => {
    return (
        <div className="px-4 w-full flex flex-col mt-[160px]">
            <div className="max-w-[731px] mx-auto flex flex-col gap-4">
                <div className="mx-auto flex flex-col items-center">
                    <div className=" w-max rounded-3xl border border-solid border-green-800 px-3 py-1 flex flex-row gap-1">
                        <img src="/assets/icon/ic_stargroup.svg" />
                        <div className="font-medium">Features</div>
                    </div>
                    <div className="text-[32px] md:text-[52px] leading-[62.4px] tracking-tighter">
                        Dive Deeper into BLOCK AI On-Chain Utility
                    </div>
                </div>
                <p className="text-white/75 mt-2"><span className="text-[#0cafcc]">$BAI</span> empowers you to navigate our products with unlimited access.</p>
            </div>
            <div className="flex flex-col md:flex-row gap-5 items-center justify-center mt-12">
                <div className="w-[237px] flex flex-col gap-4 items-center">
                    <div className="w-[88px] h-[88px] p-3 rounded-[99px] bg-gradient-to-t from-gray-600/5 to-white/5">
                        <div className="w-full h-full rounded-[99px] bg-[#68EAF20F] flex items-center justify-center">
                            <img src="/assets/icon/ic_chart.svg" />
                        </div>
                    </div>
                    <div className="text-xl tracking-tight">
                        BLOCK AI AUDITOR
                    </div>
                    <p className="text-[14px] leading-[21px] text-white/75">Smart contract and Token Code audit is made easier with Block AI Auditor, No need to pay high price to third party for you auditing services. Read More!</p>
                </div>
                <div className="w-[237px] flex flex-col gap-4 items-center">
                    <div className="w-[88px] h-[88px] p-3 rounded-[99px] bg-gradient-to-t from-gray-600/5 to-white/5">
                        <div className="w-full h-full rounded-[99px] bg-[#68EAF20F] flex items-center justify-center">
                            <img src="/assets/icon/ic_indicator.svg" />
                        </div>
                    </div>
                    <div className="text-xl tracking-tight">
                        BLOCK AI ASSISTANT
                    </div>
                    <p className="text-[14px] leading-[21px] text-white/75">Access to lastest and best AI model assistant in on place to make your AI work easy. Read More!</p>
                </div>
                <div className="w-[237px] flex flex-col gap-4 items-center">
                    <div className="w-[88px] h-[88px] p-3 rounded-[99px] bg-gradient-to-t from-gray-600/5 to-white/5">
                        <div className="w-full h-full rounded-[99px] bg-[#68EAF20F] flex items-center justify-center">
                            <img src="/assets/icon/ic_trends.svg" />
                        </div>
                    </div>
                    <div className="text-xl tracking-tight">
                        BLOCK AI MARKET TOOL
                    </div>
                    <p className="text-[14px] leading-[21px] text-white/75">Crypto Traders can now use BLOCK AI Market On-Chain Tool to help find the best investment opportunities based on AI parameters like price, market capitalization, volatility, and trading volume.Read More!</p>
                </div>
            </div>
        </div>
    )
}

export default Dive;