import "./components.scss"
import {numberWithCommas} from "../utils"
import { useAccount } from "wagmi";
import { getTokenBalance } from "../hooks/useToken.js";
import { formatUnits } from "viem";
import { TOKEN_DECIMAL } from "../config/index.js";

const PreReceiveInput = ({title, value, setValue}) => {
    const { address } = useAccount();
    const { data, isRefetching, refetch } = getTokenBalance({ address });

    return (
        <div className="flex flex-col mt-4">
            <div className="flex flex-row justify-between items-center">
                <div className="text-[14px] font-normal leading-[16.94px]">
                    {title}:
                </div>
                <div className="flex flex-row text-[13px] font-medium leading-[15.73px] text-white/60 items-center">
                    <img src='/assets/img/wallet.svg' className="ml-0.5"/>
                    <div> {numberWithCommas(formatUnits(data ? data?.toString() : 0, TOKEN_DECIMAL))} BAI</div>                    
                </div>
            </div>
            <div className="h-[41px] flex flex-row pl-3 rounded-[32px] mt-2 bg-[#08131799] border border-solid border-[#68F2C9] relative items-center">
                <img className="w-5" src='/assets/icon/ic_bai.svg' />
                <div className="presale-pay-input-tag">
                    <input 
                        type="number"
                        value={value}
                        onChange={(e) => setValue(e.target.value)}
                        placeholder="0"
                        className="px-1 w-full bg-transparent text-sm font-semibold focus:outline-none"
                        disabled
                    />
                </div>
            </div>
        </div>
    );
}

export default PreReceiveInput;