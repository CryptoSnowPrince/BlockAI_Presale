import {numberWithCommas} from "../utils"
import { useAccount } from 'wagmi';
import { getETHBalance } from '../hooks/useToken';
import CAU from "../assets/img/cau.svg"

const PrePayInput = ({title, value, setValue}) => {

    const { address } = useAccount();
    const { data: ethBalance, refetch } = getETHBalance({ address });

    const onChange = (e) => {
        if (Number(e.target.value) >= 0) {
            setValue(e.target.value)
        }
    }

    return (
        <div className="flex flex-col mt-4">
            <div className="flex flex-row justify-between items-center">
                <div className="text-[14px] leading-[16.94px]">
                    {title}:
                </div>
                <div className="flex flex-row text-[13px] font-medium leading-[15.73px] text-white/60 items-center">
                    <img src='/assets/img/wallet.svg' className='ml-0.5' />
                    {`${numberWithCommas(ethBalance?.formatted, 2)} ${ethBalance?.symbol} `}
                </div>
            </div>
            <div className="h-[41px] flex flex-row pl-3 rounded-[32px] bg-[#08131799] border border-solid border-[#68F2C9] relative items-center mt-2">
                <div className="border-none rounded-[10px] w-[90%]">
                    <div className='flex flex-row items-center'>
                        <img src={CAU} alt={CAU} className='w-4 h-4'></img>
                        <input type="number" placeholder="0" className="px-1 w-full bg-transparent text-sm font-semibold focus:outline-none" value={value} onChange={(e) => onChange(e)}/>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default PrePayInput;