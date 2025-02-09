import React from 'react'
import { BrowserRouter, Route, Routes } from 'react-router'
// import { Toaster } from 'react-hot-toast'
import Layout from './Layout1'
import FOverview from './Dash/FOverview'
import Sseting from './Dash/Sseting'
import Maps from './Dash/maps'
// import FOverview from './Dash/FOverview'
// import Users from './Dash/Users'
// import Category from './Dash/Category'
// import Size from './Dash/Size'
// import Color from './Dash/Color'
// import Product from './Dash/Product'
// import Order from './Dash/Order'

const App = () => {
  return (
    <div>
      <BrowserRouter>
        <Routes>
          <Route path='/' element={<Layout></Layout>}>
            <Route index element={<FOverview/>}></Route>
            <Route path="home" element={<FOverview />} />
            <Route path="set" element={<Sseting />} />

            <Route path='maps' element={<Maps/>}/>


          </Route>
        </Routes>
        {/* <Toaster position="top-right" reverseOrder={false} /> */}
      </BrowserRouter>
    </div>
  )
}

export default App
