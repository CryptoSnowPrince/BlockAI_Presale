import DescriptionPart from "../components/descriptionPart";
import PresaleCard from "../components/presaleCard";

import "./pages.css"


const PresalePart = () => {

    return (
        <div className="w-full display-flex justify-content-center align-items-center">
            <div className="px-4 flex flex-col lg:flex-row items-center justify-center">
                <DescriptionPart />
                <PresaleCard />
            </div>
        </div >
    );
}

export default PresalePart;