import { numberWithCommas } from "../utils"
import Slider from '@mui/material/Slider';
import { styled } from '@mui/material/styles';
import { TOKEN_PRESALE_HARDCAP } from "../config";

const PrettoSlider = styled(Slider)({
    color: '#52af77',
    height: 8,
    '& .MuiSlider-track': {
        border: 'none',
    },
    '& .MuiSlider-thumb': {
        height: 24,
        width: 24,
        backgroundColor: '#8aebd5',
        border: '2px solid currentColor',
        '&:focus, &:hover, &.Mui-active, &.Mui-focusVisible': {
            boxShadow: 'inherit',
        },
        '&::before': {
            display: 'none',
        },
    },
    '& .MuiSlider-valueLabel': {
        lineHeight: 1.2,
        fontSize: 12,
        background: 'unset',
        padding: 0,
        width: 32,
        height: 32,
        borderRadius: '50% 50% 50% 0',
        backgroundColor: '#52af77',
        transformOrigin: 'bottom left',
        transform: 'translate(50%, -100%) rotate(-45deg) scale(0)',
        '&::before': { display: 'none' },
        '&.MuiSlider-valueLabelOpen': {
            transform: 'translate(50%, -100%) rotate(-45deg) scale(1)',
        },
        '& > *': {
            transform: 'rotate(45deg)',
        },
    },
});

const Stats = ({ raisedAmount }) => {

    return (
        <div className="flex flex-col mt-4">
            <div>Raised <span className="text-[#65f0ca]">{raisedAmount}</span> of {numberWithCommas(TOKEN_PRESALE_HARDCAP)} CAU</div>
            <PrettoSlider aria-label="Volume" value={raisedAmount / TOKEN_PRESALE_HARDCAP} />
        </div>
    )
}

export default Stats