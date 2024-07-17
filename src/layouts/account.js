import { useAccount, useDisconnect, useEnsAvatar, useEnsName } from 'wagmi'

export function Account() {
  const { address } = useAccount()
  const { disconnect } = useDisconnect()
  const { data: ensName } = useEnsName({ address })
  const { data: ensAvatar } = useEnsAvatar({ name: ensName })

  const displayAddress = address && ensName ? `${ensName} (${address})` : address

  return (
    <div className="h-9 flex flex-row items-center justify-center rounded-3xl px-4 py-2 text-[12px] bg-cyan-500">
        {ensAvatar && <img alt="ENS Avatar" src={ensAvatar} />}
        <button onClick={() => disconnect()}>{`Disconnect (${displayAddress.slice(0, 4) + " ... " + displayAddress.slice(-4)})`}</button>
    </div>
  )
}