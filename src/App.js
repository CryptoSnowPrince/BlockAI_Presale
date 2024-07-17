import React, { useMemo } from 'react';

import { toast, ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import Navbar from './layouts/navbar';
import PresalePart from "./pages/presalePart"
import Claim from './pages/claim';
import ThemeContext from './context/themeContext';

import './App.css';
import CAU from "./assets/img/cau.svg"
import Dive from './pages/dive';
import Price from './pages/price';
import Tokenomics from './pages/tokenomics';
import HowTo from './pages/howTo';
import Copyright from './pages/copyright';
import { WagmiProvider } from 'wagmi'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { config } from './config';

const queryClient = new QueryClient()

function App() {
  const tokens = [
    { ft: "CAU", icon: CAU },
  ];
  return (
    <div className="App bg-[#071619] bg-center bg-cover" style={{ backgroundImage: "url('/assets/img/pattern.png')"}}>
      <ThemeContext.Provider value={tokens}>
        <WagmiProvider config={config}>
          <QueryClientProvider client={queryClient}>
            <Navbar />
            <div className='px-5 md:px-10 lg:px-0 pt-6 md:pt-[100px] pb-[160px] flex flex-col'>
              <PresalePart />
              <Claim />
              <Dive />
            </div>
            <Price />
            <div className='py-[142px] flex flex-col'>
              <Tokenomics />
              <HowTo />
            </div>
            <Copyright />
            <ToastContainer autoClose={3000} draggableDirection="x" toastStyle={{ backgroundColor: "#05bfc4", color: "white" }} />
          </QueryClientProvider>
        </WagmiProvider>
      </ThemeContext.Provider>
    </div>
  );
}

export default App;
