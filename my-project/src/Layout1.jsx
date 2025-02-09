import React from 'react'
import Sidebar from './Dash/Sider';
import { Outlet } from "react-router";

// import Navbar from './Navbar';
// import DataLoader from '../DataUtils/Loader';
// import AuthHook from '../Context/AuthContext';

function Layout() {
    // const { loader } = AuthHook()
    return (
        <div className='  sm:h-[100vh] bg-gray-50'>
           
            <div className=' flex '>
                <div className=' w-fit'>
                    <Sidebar />
                </div>
                <div className=' w-[100%] bg-[#f0f0f0]  '>
                    <Outlet />
                </div>
            </div>
            
        </div>
    )
}

export default Layout