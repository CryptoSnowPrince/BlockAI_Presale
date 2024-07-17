const Tokenomics = () => {
    return (
        <div className="px-4 w-full flex flex-col gap-12">
            <div className="max-w-full md:max-w-[572px] mx-auto flex flex-col gap-4">
                <div className="mx-auto flex flex-col gap-2 items-center">
                    <div className="w-max rounded-3xl border border-solid border-green-800 px-3 py-1 flex flex-row gap-1">
                        <img src="/assets/icon/ic_stargroup.svg" />
                        <div className="font-medium">tokenomics</div>
                    </div>
                </div>
                <p className="text-white/75">Deep dive into the key aspects of our supply, geared to enable growth, longevity and community.</p>
            </div>
            <div className="flex-wrap md:flex-nowrap flex flex-row gap-8 justify-center">
                <div className="w-[130px] flex flex-col gap-[18.9px] items-center">
                    <CircleProgressBar percent={5}/>
                    <div className="flex flex-col gap-[7.56px]">
                        <div>New User Acquisition</div>
                        <p className="text-[14px] leading-[21px] text-white/75">5% of total supply</p>
                    </div>
                </div>
                <div className="w-[130px] flex flex-col gap-[18.9px] items-center">
                    <CircleProgressBar percent={40}/>
                    <div className="flex flex-col gap-[7.56px]">
                        <div>Presale Event</div>
                        <p className="text-[14px] leading-[21px] text-white/75">40% of total supply</p>
                    </div>
                </div>
                <div className="w-[130px] flex flex-col gap-[18.9px] items-center">
                    <CircleProgressBar percent={25}/>
                    <div className="flex flex-col gap-[7.56px]">
                        <div>DEX & CEX Listing</div>
                        <p className="text-[14px] leading-[21px] text-white/75">25% of total supply</p>
                    </div>
                </div>
                <div className="w-[130px] flex flex-col gap-[18.9px] items-center">
                    <CircleProgressBar percent={30}/>
                    <div className="flex flex-col gap-[7.56px]">
                        <div>BLOCK AI NFT Staking</div>
                        <p className="text-[14px] leading-[21px] text-white/75">30% of total supply</p>
                    </div>
                </div>

            </div>
        </div>
    )
}

const CircleProgressBar = ({percent}) => {
    return (
        <div className={`progress`}>
            <span className="title timer" data-from="0" data-to={percent} data-speed="1800">{percent}</span>
            <div className="overlay"></div>
            <div className={`left animate${percent}`}></div>
            <div className="right"></div>
        </div>
    )
}
export default Tokenomics;